# screw-you-guys-im-going-home

An exercise in [yak-shaving](http://www.hanselman.com/blog/YakShavingDefinedIllGetThatDoneAsSoonAsIShaveThisYak.aspx), and bash.

In an effort to ensure I don't spend too much time in the office (max 8 hours per day), this script will schedule a notification based on your first machine login of the day. It'll notify you at 6pm, or in 8 hours time, whichever comes sooner.

### Install

`mkdir -p screw-you-guys-im-going-home && git clone https://github.com/jazlalli/screw-you-guys-im-going-home.git ./screw-you-guys-im-going-home`
`cd screw-you-guys-im-going-home && npm install`
`npm run setup`

**Important note** - The setup process removes any existing install of [sleepwatcher](http://www.bernhard-baehr.de/), and associated LaunchDaemons & LaunchAgents. If you don't want this to happen, don't run the setup. Manual instructions will be provided below (eventually).

In summary, the setup downloads and installs sleepwatcher, copies relevant files to relevant locations, changes permissions on them, sets up launchd logging, and then starts a launchd job. The job will appear in the list with the label `de.bernhard-baehr.sleepwatcher`.