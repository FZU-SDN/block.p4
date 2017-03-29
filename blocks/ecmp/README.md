# ECMP P4

## TODO:

### Common PreSteps

start the mininet:

```
./run_demo.sh
```

deploy the scripts:

```
./add_entry.sh

cd mclearn
./mc_learn.sh
```

validate:

```
mininet> pingall
```

### Target Specific Steps

1.ECMP commands: 

```
cd cmd
./ecmp.sh
```

2.start sending packets using a script, the srcIP of each paket was different from each other. You can refer to the script for more informations.

```
./send.py
```

3.Check the counter with the runtime_CLI:

```
./simple_switch_CLI --thrift-port 22222

counter_read ecmp_counter 1
counter_read ecmp_counter 2
counter_read ecmp_counter 3
```

You can see the result like this:

```
RuntimeCmd: counter_read ecmp_counter 1
ecmp_counter[1]=  BmCounterValue(packets=371, bytes=22260)
RuntimeCmd: counter_read ecmp_counter 2
ecmp_counter[2]=  BmCounterValue(packets=313, bytes=18780)
RuntimeCmd: counter_read ecmp_counter 3
ecmp_counter[3]=  BmCounterValue(packets=316, bytes=18960)
```

## Explaination

See [Action Profile](https://github.com/p4lang/tutorials/tree/master/examples/action_profile#action-profile) for more informations.

Chen, 2017.3.27