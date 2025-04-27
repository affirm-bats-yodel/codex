# codex

Docker Image for Codex Agent

## Why?

* Because on Windows, it doesn't support natively.
  * e.g. `Running Linux command -> Error -> (Thinking to Reverse Engineer how to read a file) -> ...`

## Changes from Origin

* added `vim` editor to handle git commands and doing minimal code editing tasks.
* [scripts/init_workspace.sh](./scripts/init_workspace.sh): add script to handle workspace directory's file permission.
  * follows Original Dockerfile's style to minimize prvililege issues.

## Versions

* [0.1.2504211509](https://github.com/affirm-bats-yodel/codex/releases/tag/0.1.2504211509)
  * OCI Image: `ghcr.io/affirm-bats-yodel/codex:0.1.2504211509`
  * https://github.com/affirm-bats-yodel/codex/pkgs/container/codex/399695519?tag=0.1.2504211509
* [0.1.2504221401](https://github.com/affirm-bats-yodel/codex/releases/tag/0.1.2504221401)
  * OCI Image: `ghcr.io/affirm-bats-yodel/codex:0.1.2504221401`
  * `locales` package has been added to handle other languages.
  * https://github.com/users/affirm-bats-yodel/packages/container/codex/401495497?tag=0.1.2504221401
* [0.1.2504251709]()
  * OCI Image: `ghcr.io/affirm-bats-yodel/codex:0.1.2504251709`
  * Update `@openai/codex` package to `0.1.2504251709`
  * https://github.com/affirm-bats-yodel/codex/pkgs/container/codex/403337564?tag=0.1.2504251709

## How to use?

* Please prepare OpenAI API Key from OpenAI Dashboard. You'll need to verify your **REAL HUMAN** identity to use
OpenAI's Model.
* You can put OpenAI API Key as: `-e OPENAI_API_KEY=...`
* Or You can put OpenAI API Key as: `--env-file .env`
* You'll need to adjust `--entrypoint` to run on bash or run codex directly.

```shell
docker run -it --rm ghcr.io/affirm-bats-yodel/codex:0.1.2504211509
```

## Disclaimer

* [codex](https://github.com/openai/codex) repository doesn't make any releases and tags.
this documentation and code follows [3eba86a55353f6b6f0efee19704b8d11e683b4ad](https://github.com/openai/codex/blob/3eba86a55353f6b6f0efee19704b8d11e683b4ad)

## LICENSE

* Follow Original Repository's LICENSE (`Apache License 2.0`)
* See [LICENSE](./LICENSE)
