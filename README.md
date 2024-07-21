# pwntainer

Docker container will all required CTF pwn tools. Had to do this cuz macOS moment.

### Build:

```sh
docker build --platform=linux/amd64 -t pwn:pwn .
```

### Use:

```sh
alias pwn="docker run --cap-add=SYS_PTRACE -p 31337:31337 -v $(pwd):/pwn -it pwn:pwn bash"
```

NOTE: Connection to lldb-server inside container doesn't work as of latest commit.

Modified from [ScarletFireLabs](https://github.com/scarletfirelabs/docker-binaryexploitation).
