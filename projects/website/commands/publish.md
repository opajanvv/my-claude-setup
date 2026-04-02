Publish the site to the server. Follow these steps in order:

1. Check for uncommitted changes in user/pages/ and user/themes/ with `git status`. If there are changes, commit them first using the auto-committer agent.
2. Run `bash publish.sh` from the project root to rsync and clear cache.
3. Verify the publish succeeded (look for the "Publish complete" message).
4. If the publish fails, show the error and suggest a fix.
