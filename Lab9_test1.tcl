# Filename: test1.tcl
#——-Event scheduler object creation——–#
set ns [new Simulator]
#———-creating trace objects—————-#
set nt [open test1.tr w]
$ns trace-all $nt
#———-creating nam objects—————-#
set nf [open test1.nam w]
$ns namtrace-all $nf
#———-Setting color ID—————-#
$ns color 1 darkmagenta
$ns color 2 yellow
$ns color 3 blue
$ns color 4 green
$ns color 5 black
#———- Creating Network—————-#
set totalNodes 3
for {set i 0} {$i < $totalNodes} {incr i} {
    set node_($i) [$ns node]
}
set server 0
set router 1
set client 2
#———- Creating Duplex Link—————-#
$ns duplex-link $node_($server) $node_($router) 2Mb 50ms DropTail
$ns duplex-link $node_($router) $node_($client) 2Mb 50ms DropTail
$ns duplex-link-op $node_($server) $node_($router) orient right
$ns duplex-link-op $node_($router) $node_($client) orient right
#————Labelling—————-#
$ns at 0.0 "$node_($server) label Server"
$ns at 0.0 "$node_($router) label Router"
$ns at 0.0 "$node_($client) label Client"

$ns at 0.0 "$node_($server) color blue"
$ns at 0.0 "$node_($client) color blue"
$node_($server) shape hexagon
$node_($client) shape hexagon
#———finish procedure——–#
proc finish {} {
    global ns nf nt
    $ns flush-trace
    close $nf
    close $nt
    puts "running nam…"
    exec nam test1.nam &
    exit 0
}
#Calling finish procedure
$ns at 10.0 "finish"
$ns run
