// print-pings.click

// This configuration reads packets from a device, and prints out any ICMP
// echo requests it receives.

// You can run it at user level (as root) as
// 'userlevel/click < conf/print-pings.click'
// or in the kernel with
// 'click-install conf/print-pings.click'

require(package "fizzbuzzipprint");

FromDevice(eth0)				// read packets from device
						// (assume Ethernet device)
   -> Classifier(12/0800)			// select IP-in-Ethernet
   -> Strip(14)					// strip Ethernet header
   -> CheckIPHeader				// check IP header, mark as IP
   -> IPFilter(allow icmp && icmp type echo)	// select ICMP echo requests
   -> FizzBuzzIPPrint				// print them out
   -> Discard;
