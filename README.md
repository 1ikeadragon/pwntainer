# pwntainer

Docker container with all required CTF pwn tools. Had to do this cuz macOS moment.

### Build:

```sh
docker build -t pwn:pwn .
```

### Use:

```sh
alias pwn="docker run  --privileged --cap-add=SYS_PTRACE -p 31337:31337 -v $(pwd):/pwn -it pwn:pwn bash"
```
### NOTE:

When I tried debugging inside the container built with and run as `--platform=linux/amd64`, it did not work. I looked around a bit to find that this is a known issue with Docker on Mac. As an alternative to debug and run x86_64 binaries, I switched to [Colima](https://github.com/abiosoft/colima). 

It is slower because it uses QEMU to emulate x86_64 but it works flawlessly. I guess the performance hit is bearable as long as everything works. So until Docker fixes their issue with Rosetta2 we'll just have to use QEMU.

Here's the command to install and set everything:
```sh
brew install docker
brew install colima
brew install docker-buildx
brew install docker-compose
colima start --profile rosetta --cpu 8 --memory 8 --disk 10 --arch x86_64 --vm-type=vz --vz-rosetta
docker build -t pwn:pwn .
docker run --security-opt seccomp=unconfined --privileged --cap-add=SYS_PTRACE -p 31337:31337 -v ./:/pwn -it pwn:pwn bash
```

Modified from [ScarletFireLabs](https://github.com/scarletfirelabs/docker-binaryexploitation).
