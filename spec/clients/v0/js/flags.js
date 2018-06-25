const [_, __, port, apiKey, flagUUID] = process.argv;
var done = (function wait () { if (!done) setTimeout(wait, 1000) })();

var A15kInteractions = require('../../../../clients/0.1.0/javascript/dist/bundle.js')

var defaultClient = A15kInteractions.ApiClient.instance;

defaultClient.basePath = `http://localhost:${port}/api/v0`;

const { api_id } = defaultClient.authentications;
api_id.apiKey = `ID ${apiKey}`

var api = new A15kInteractions.FlagsApi()

api.createFlag({
  content_uid: flagUUID,
  user_uid: '123456',
  type: 'typo',
}).then((flag) => {
  console.log(flag.id)
  done = true
}).catch(err => {
  console.error(err)
  done = true
})
