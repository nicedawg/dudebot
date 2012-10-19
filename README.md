# Dudebot

This is a version of GitHub's Campfire bot, hubot. He's pretty cool.

This guy's outfitted with an AIM adapter and specially designed to join
chatrooms and quickly become the life of the party... er, I mean quickly
improve productivity.

See [hubot's home page][hubot] for more information

[hubot]: https://github.com/github/hubot/wiki

To run dudebot:

1\. make sure the following environment variables are defined:

  > HUBOT_AIM_NAME
  > HUBOT_AIM_EMAIL
  > HUBOT_AIM_PASSWORD
  > HUBOT_AIM_ROOMS

2\. and then run `./bin/dudebot`


To install and run on Windows:
1. Use http://windows.github.com/ to download a Git for Windows GUI
2. Clone the repo to your PC.
3. Install NodeJS - http://nodejs.org/dist/v0.8.2/node-v0.8.2-x86.msi
4. Open a command prompt and change to your dudebot directory
5. run `bin/dudebot.bat` to start dudebot in your shell
6. run `bin/dudebot.bat -a aim` to start dudebot in AIM