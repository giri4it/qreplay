# qreplay

This is a simple tool to drive capturing, saving, and replaying HTTP requests. It depends on `pcap_tools`, `tshark`, `dumpcap`, and `httperf`.

## Use

```shell
gem install qreplay
qreplay [capture|replay|transform|capture_only] [options]
```

- __capture__ - Use `tshark` to capture http packets.
- __replay__ - Replay HTTP session file with requests to a host/port.
- __transform__ - Transform a dumpcap file to a sesslog file. This is executed automatically in capture mode.
- __capture-only__ - Perform a capture without a transform step.

Options:
```
-c, --capture-time=<f>         Capture time length in seconds (default: 60.0)
-a, --capture-interface=<s>    Traffic capture interface (uses dumpcap default if not specified)
-p, --port=<i>                 Capture/replay traffic to port (default: 80)
-h, --host=<s>                 Replay host (default: 0.0.0.0)
-r, --req-sec=<i>              Requests per second for replays (default: 20)
-t, --total-requests=<i>       Total replay requests to send (default: 10000)
-u, --capture-file=<s>         Output file (default: ./qreplay.sesslog)
-f, --pcap-file=<s>            Temporary intermediate pcap file path (default: ./qreplay.pcap)
-i, --timeout=<i>              Timeout for replay requests (default: 10)
-s, --tshark-binary=<s>        TShark binary file location (default: tshark)
-d, --dumpcap-binary=<s>       dumpcap binary file location (default: dumpcap)
-e, --httperf-binary=<s>       httperf binary file location (default: httperf)
-v, --version                  Print version and exit
-l, --help                     Show this message
```

Capturing TCP traffic requires root privileges on most systems.

## Example

You want to capture traffic on a live web server. On the remote machine run:

```
sudo qreplay capture --capture-time 60 --port 80
```

This will use `tshark` to capture TCP traffic to/from port 80 for 60 seconds, stitch together HTTP requests from the TCP traffic, and save requests to `./qreplay.sesslog`. If you observe this file you will notice that each request line contains an HTTP method, path, and body in a format acceptable to `httperf`.

This example is invoking `sudo` so that it has access to the capture device.

You can then replay with:

```
qreplay replay --host 127.0.0.1 --port 80 --req-sec 50
```

To replay these requests to the local server at port 80 at a rate of 50 per second.

## Installing

Mac OS X (homebrew):
```
gem install qreplay
brew install wireshark httperf
```

Yum package manager:
```
gem install qreplay
yum install wireshark httperf
```

## httperf

By default, httperf only handles HTTP bodies with 10,000 bytes or less, which is easy to exceed if you're testing an application that POSTs significant amounts of data. We've increased a few of the arbitrary limitations in httperf in our fork, [here](https://github.com/quizlet/httperf), we recommend using it if you're hitting limits in the mainline httperf.

## License

The qreplay copyright is owned by Old School Industries LLC. We've licensed it under the MIT License, which can be found in `LICENSE.md`.

## Thanks

Thanks to Bertrand Paquet for developing pcap tools and licensing it under the Apache 2 license. You can find more about pcap_tools [here](https://github.com/bpaquet/pcap_tools).

