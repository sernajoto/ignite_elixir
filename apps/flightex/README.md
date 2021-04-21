# Flightex

**Chapter II - Module 3 - Challenge 01**

Must create a flight booking application, where there will be the registration of users and the registration of reservations for a user. 
Agent must be used for storage.

```Elixir
%User{
	id: uuid,
	name: string,
	email: string,
	cpf: cpf
}

%Booking{
	id: uuid,
	complete_date: naiveDateTime,
	origin_city: string,
	destination_city: string,
	user_id: uuid
}
```