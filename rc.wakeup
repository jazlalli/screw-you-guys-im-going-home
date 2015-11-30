#!/bin/bash
RUNNING=`ps | grep -w "sleep" | grep -v grep | grep -v $$ | awk '{print $4}'`;

if [ "$RUNNING" = "sleep" ]; then
  echo "Already running, $RUNNING"
  exit 1;
fi

now=`date "+%s"`;
eod=`date -j -f '%T' "18:00:00" "+%s"`;
max=28800; # 8 hours in seconds
diff=$(($eod-$now));

if [[ diff < max ]]; then
  DELAY=$diff;
else
  DELAY=$max;
fi

IN=`date -j -f '%s' "$DELAY" "+%H:%M"`;
HOURS=${IN:1:1};
MINS=${IN:3:2};

echo "notifying in $DELAY secs ($HOURS hours and $MINS mins)";

sleep $DELAY;
/usr/bin/osascript -e "display notification \"Get the hell outta here\" with title \"Go Home\"";
