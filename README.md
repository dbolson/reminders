# reminders-api client

```
f = Reminders::Client.new(email, api_key)

f.event_lists
f.event_list(id)
f.create_event_list(name: 'name')
f.update_event_list(id, name: 'another name')
f.delete_event_list(id)

f.event_list.status
f.event_list.raw_response

f.events
f.events(event_list)
```
