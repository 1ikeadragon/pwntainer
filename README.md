# pwntainer

Docker container with all required CTF pwn tools. Had to do this cuz macOS moment.

### Build:

```sh
docker build -t pwn:pwn .
```

### Use:

```sh
alias pwn="docker run --security-opt seccomp=unconfined --privileged --cap-add=SYS_PTRACE -p 31337:31337 -v ./:/pwn -it pwn:pwn bash"
```
### Note for debugging x86_64 on Apple Silicon:

When I tried debugging inside the container built with and run as `--platform=linux/amd64`, it did not work. I looked around a bit to find that this is a known issue with Docker on Mac. As an alternative to debug and run x86_64 binaries, I switched to [Colima](https://github.com/abiosoft/colima). 

It is slower because it uses QEMU to [emulate the entire VM in x86_64](https://lima-vm.io/docs/config/vmtype/) but it works flawlessly. I guess the performance hit is bearable as long as everything works. So until [Docker fixes their issue](https://github.com/docker/for-mac/issues/6921) with Rosetta2 we'll just have to use QEMU.

Here's the command to install and set everything:
```sh
brew install docker
brew install colima
brew install docker-buildx
colima start -p x64 -a x86_64 -c 8 -m 4 -d 10 --mount-type virtiofs --ssh-agent --vm-type vz --vz-rosetta
docker-buildx -t pwn:pwn .
docker run --security-opt seccomp=unconfined --privileged --cap-add=SYS_PTRACE -p 31337:31337 -v ./:/pwn -it pwn:pwn bash
```

Modified from [ScarletFireLabs](https://github.com/scarletfirelabs/docker-binaryexploitation).
