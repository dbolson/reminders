# reminders-api client

```
f = Reminders::Client.new(email, api_key)
f.event_lists
  [event_list1, event_list2]
f.event_list(id)
f.create_event_list(params)
f.update_event_list(params)
f.delete_event_list(id)

f.event_lists.status
f.event_lists.raw_response

f.events
f.events(event_list)
```
