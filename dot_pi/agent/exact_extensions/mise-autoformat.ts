import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * mise-autoformat
 *
 * Runs `mise format:fix` after every turn in which the agent wrote files to
 * disk (via `write`, `edit`, or `ast_edit`). Formatting runs only after the
 * writes have landed on disk, in the session's working directory, so mise
 * resolves the enclosing project's formatting configuration.
 */
export default function miseAutoformat(pi: ExtensionAPI) {
  // Tool names that write to disk in this harness.
  const FILE_TOOLS: Record<string, true> = { write: true, edit: true, ast_edit: true };

  // Number of file-writing tool calls observed during the current turn.
  let modifiedFiles = 0;

  // Start each turn with a clean slate.
  pi.on("turn_start", () => {
    modifiedFiles = 0;
  });

  // Count file writes as they happen (only successful ones).
  pi.on("tool_result", (event) => {
    if (event.isError || !FILE_TOOLS[event.toolName]) return;

    const input = (event.input ?? {}) as Record<string, unknown>;
    switch (event.toolName) {
      case "write":
      case "edit":
        if (typeof input.path === "string") modifiedFiles++;
        break;
      case "ast_edit":
        if (Array.isArray(input.paths) && input.paths.length > 0) modifiedFiles++;
        break;
    }
  });

  // After the turn's files are written, reformat them.
  pi.on("turn_end", async (_event, ctx) => {
    const touched = modifiedFiles;
    modifiedFiles = 0;
    if (touched === 0) return;

    try {
      ctx.ui.notify(`Running mise format:fix (${touched} file${touched === 1 ? "" : "s"})`, "info");
      const result = await pi.exec("mise", ["format:fix"], { cwd: ctx.cwd });
      // Failures are ignored: a repo without a `format:fix` task is a
      // normal case, and running + failing is cheaper than probing for it.
      if (result.code !== 0) {
        console.debug(
          `mise format:fix did not apply (code ${result.code}): ${result.stderr || result.stdout}`,
        );
      }
    } catch (err) {
      console.debug("mise-autoformat error", err);
    }
  });
}
