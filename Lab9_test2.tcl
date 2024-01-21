# Filename: test2.tcl

# Event scheduler object creation
set mySimulator [new Simulator]

# Creating trace objects
set myTraceFile [open test2.tr w]
$mySimulator trace-all $myTraceFile

# Creating nam objects
set myNamFile [open test2.nam w]
$mySimulator namtrace-all $myNamFile

# Setting color ID
$mySimulator color 1 darkmagenta
$mySimulator color 2 yellow
$mySimulator color 3 blue
$mySimulator color 4 green
$mySimulator color 5 black

# Creating Network
set totalNodes 6
for {set i 0} {$i < $totalNodes} {incr i} {
    set myNode_($i) [$mySimulator node]
}

set myServer 0
set myRouter 1
set myClientStart 2
set myClientEnd 6

# Setting Colors
$myNode_(0) color green
$myNode_(1) color blue
$myNode_(2) color red
$myNode_(3) color red
$myNode_(4) color red
$myNode_(5) color red

# Setting Labels and Shapes
$mySimulator at 0.0 "$myNode_(0) label \"Server\""
$mySimulator at 0.0 "$myNode_(1) label \"Router\""

for {set i $myClientStart} {$i < $myClientEnd} {incr i} {
    $mySimulator at 0.0 "$myNode_($i) label \"Client$i\""
    $mySimulator at 0.0 "$myNode_($i) color blue"
    $myNode_($i) shape square
}

# Creating Duplex Links
for {set i $myClientStart} {$i < $myClientEnd} {incr i} {
    $mySimulator duplex-link $myNode_($myServer) $myNode_($myRouter) 2Mb 50ms DropTail
    $mySimulator duplex-link $myNode_($myRouter) $myNode_($i) 2Mb 50ms DropTail
    $mySimulator duplex-link-op $myNode_($myServer) $myNode_($myRouter) orient right
    $mySimulator duplex-link-op $myNode_($myRouter) $myNode_($i) orient right
}

# Finish Procedure
proc myFinish {} {
    global mySimulator myNamFile myTraceFile
    $mySimulator flush-trace
    close $myNamFile
    close $myTraceFile
    puts "Running nam…"
    exec nam test2.nam &
    exit 0
}

# Calling finish procedure
$mySimulator at 10.0 "myFinish"

# Run the simulation
$mySimulator run













