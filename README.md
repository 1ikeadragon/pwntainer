# pwntainer

Docker container with all required CTF pwn tools. Had to do this cuz macOS moment.

### Build:

```sh
docker build --platform=linux/amd64 -t pwn:pwn .
```

### Use:

```sh
alias pwn="docker run  --privileged --cap-add=SYS_PTRACE -p 31337:31337 -v $(pwd):/pwn -it pwn:pwn bash"
```

Modified from [ScarletFireLabs](https://github.com/scarletfirelabs/docker-binaryexploitation).
