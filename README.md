# reminders-api client
```
f = Reminders::Client.new(email, api_key)
f.event_lists
  [event_list1, event_list2]
f.event_list(id)
f.create_event_list(params)
f.update_event_list(params)
f.delete_event_list(id)

f.events
f.events(event_list)

"event_lists": [
  {
    "id":3,
    "name":"name",
    "created_at":"2013-04-19T13:14:24Z",
    "updated_at":"2013-04-19T13:14:24Z"
  },
  {
    "id":2,
    "name":"another name",
    "created_at":"2013-04-17T15:12:20Z",
    "updated_at":"2013-04-19T13:06:37Z"
  }
],
"status":200

EventList
  #id
  #name
  #created_at
  #updated_at
```
