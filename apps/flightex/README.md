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

**Chapter II - Module 3 - Challenge 02**

Must improve your solution to the previous challenge. It should now also be possible to generate flight booking reports according to the time interval specified in the function call.
The report must be in .csv format.

```CSV
user_id1,Vitória,Salvador,2021-03-22 19:29:25.607218
user_id2,São Paulo,Rio de Janeiro,2021-03-14 12:12:25.607218
user_id1,São Paulo,Londres,2021-04-18 08:45:25.607218
```
