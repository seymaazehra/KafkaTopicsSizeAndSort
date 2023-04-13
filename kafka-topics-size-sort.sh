#!/bin/bash




$kafka-log-dirs.sh --bootstrap-server $kafkaIP --describe |

 grep '^{' |
jq -c '.brokers[].logDirs[].partitions | map(.topic=(.partition|sub("-P\\d+$";""))) | group_by(.size)[] | group_by(.topic)[] | {topic:.[0].topic, partitions: map({partition: .partition, size: .size}) |  map({partition, size :(.size/1000 | tostring + " KB")})}'
