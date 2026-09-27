# AGENT.md

## Development guidelines

This project follows the TSG Global development guidelines in the sibling repo
[`../elixir-dev-guidelines`](https://github.com/tsg-global/elixir-dev-guidelines).
Before reading it, bring the sibling checkout up to date so you work from the
current conventions: `git -C ../elixir-dev-guidelines pull --ff-only` (it should
be on `master`; if the pull fails or the checkout is dirty, say so and continue
with what is there). Then read its `elixir/README.md` index first — it lists
which topic file covers what. Do NOT read the whole repo up front: open a topic
file only when you start work it covers (database → `database.md`, RabbitMQ →
`rabbitmq.md`, …), and `workflow.md` when creating a new app or repo.

Never commit, push, or open a PR without the operator's explicit approval for
that specific action. Approval is one-time — a yes for one commit/push/PR
never carries over to the next.
