nationisms = [
  'Thoughts?',
  'FYI',
  'Advise',
  'goin hollwood, sorta of',
  'because of awesome',
  'its got charme',
  'guess who just won another award',
  'this is fine',
  '#mashable'
]

mashables = [
  '#awards',
  '#coffee',
  '#content-regurgitation',
  '#webbies',
  '#thisisfine',
  '#viral',
  '#retweet',
  '#creative',
  '#digital',
  '#dreamitreal'
]

deaths = [
  'that was bad and i should feel bad',
  'bbl cruel world',
  'this was not fine',
  'remember me with retweets #twitter',
]

parties = [
  'http://userserve-ak.last.fm/serve/_/45346459/Andrew+WK+conan+obrien+and.gif',
  'http://www.jamspreader.com/wp-content/uploads/2013/03/tumblr_mamljbcorW1rpbhe1o1_400.gif',
  'http://aux-www.s3.amazonaws.com/wp-content/uploads/2012/09/Sweeping-Nanny.gif',
  'http://24.media.tumblr.com/tumblr_m9vzjhC72B1qb4lmho1_500.gif',
  'http://i18.photobucket.com/albums/b128/tommymunkey/th_AndrewW.gif',
  'http://media.tumblr.com/tumblr_mcvdxrIk0y1qzqh3y.gif',
  'http://videogum.com/img/thumbnails/photos/andrew_wk.gif'
]

max_possible_fail = 10
fail_count = 0

module.exports = (robot) ->

  robot.respond /fail/, (msg) ->
    fail_count++

    message = 'E: [';

    for i in [1..max_possible_fail] by 1
      if fail_count == i
        message += '/'
      else
        message += '-'
    message += '] F'

    if fail_count == max_possible_fail
      msg.send 'Fail Meter: ' + message + ' ' + '\n\n' + msg.random deaths
      process.exit 0
    else
      msg.send 'Fail Meter: ' + message

  robot.hear /party/i, (msg) ->
    msg.send msg.random parties

  robot.respond /wk bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    for i in [0..count-1]
      msg.send msg.random parties

  robot.hear /hitcents/i, (msg) ->
    # console.log(msg.message.user.reply_to)
    # console.log(msg.message)
    # console.log(msg.robot)
    msg.send msg.random nationisms

  robot.hear /mashable/i, (msg) ->
    msg.send '"' + msg.message.text + '" #' + msg.message.user.name + ' ' + msg.random mashables

  robot.hear /edit everything/i, (msg) ->
    memeGenerator msg, 'boromir.jpg', 'ONE DOES NOT SIMPLY', 'MAKE EVERYTHING EDITABLE', (url) ->
      msg.send url

  robot.hear /aaa/i, (msg) ->
    memeGenerator msg, 'aliens.jpg', '', 'PROJECT MANAGEMENT', (url) ->
      msg.send url

  robot.hear /push it live/i, (msg) ->
    memeGenerator msg, 'http://dougernst.files.wordpress.com/2010/03/do-it-live.jpg', '', 'PUSH IT LIVE', (url) ->
      msg.send url

  robot.respond /kirk game (.+)/i, (msg) ->
    string = msg.match[1].split(' ')
    if string.length <= 1
      msg.send 'y u only send one word to kirk game'
    else
      letters = []
      words = []
      vowels = ['a', 'e', 'i', 'o', 'u']
      pattern = ''
      count = 0

      for key,value of string

        if value.length <= 2
          pattern += value
          continue
        else
          pattern += '{' + count + '}'

        two = value.substring(0,2)

        if vowels.indexOf(two[0]) == -1 && vowels.indexOf(two[1]) == -1
          letters.push(value.substring(0,2))
          words.push(value.substring(2, value.length))
        else
          letters.push(value.substring(0,1))
          words.push(value.substring(1, value.length))

        count++

      new_words = []
      for i in [0..words.length-1] by 1
        new_words.push(letters[0] + words[i]) if i == words.length - 1
        new_words.push(letters[i+1] + words[i]) if i < words.length - 1

      for key,value of new_words
        pattern = pattern.replace('{' + key + '}', ' ' + value + ' ')

      msg.send pattern

  robot.hear /jc test/, (msg) ->
    console.log(msg)
    robot.send "hitcentswebdev", "Test"

# stolen from meme captain
memeGenerator = (msg, imageName, text1, text2, callback) ->
  if imageName.indexOf('http://') == -1
    imageUrl = "http://v1.memecaptain.com/" + imageName
  else
    imageUrl = imageName

  msg.http("http://v1.memecaptain.com/g")
  .query(
    u: imageUrl,
    t1: text1,
    t2: text2
  ).get() (err, res, body) ->
    return msg.send err if err
    result = JSON.parse(body)
    if result? and result['imageUrl']?
      callback result['imageUrl']
    else
      msg.reply "Sorry, I couldn't generate that meme."
