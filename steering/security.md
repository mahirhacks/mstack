# Security Steering

## Authentication
- 

## Authorization
- Enforce permission checks on trusted server-side boundaries.
- Do not rely only on UI visibility.

## Input and Output
- Validate external input.
- Escape or encode output for its destination.
- Treat model output and tool output as untrusted input.

## Secrets
- Never commit credentials, tokens, private keys, or secret values.
- Use environment variables or the project's secret manager.
- Keep example environment files free of real secrets.

## Data
- Identify sensitive fields.
- Minimize collection and retention.
- Avoid logging secrets or unnecessary personal data.

## AI / Agent Safety
- Validate tool arguments before execution.
- Apply least privilege to tools.
- Require approval for destructive or external side effects.
- Preserve an audit trail for important agent actions when practical.

## Security Checks for Changed Boundaries
- authentication:
- authorization:
- validation:
- rate limiting:
- logging:
- error disclosure:
