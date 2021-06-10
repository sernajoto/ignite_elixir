# Exmeal

**Chapter III - Module 4 - Challenge 01**

Must create an application to monitor food consumption during the day.

The schema of a meal must have the following fields:
```elixir
# Meal
{
	id: id,
	description: description,
	date: date,
	calories: calories
}
```
Note: The Id must be generated automatically, it can be an integer or a UUID, but it cannot be repeated.

- To create a field with a date in Ecto, in your schema, you must use the type `:datetime`;
- The `description` field will contain information about what was currently consumed (data type: string);
- The `date` field should store the date and time the food was consumed;
- The `calories` field will have information about the amount of calories consumed in the food;
- Data must be saved in a table called `meals`.

The application must have routes to meet the requirements of a normal CRUD:

1. It must be possible to register a meal made, returning a status of `201` and the information created;
2. It must be possible to update an already registered meal, returning a `200` status and the updated meal;
3. It must be possible to display an existing meal, returning a `200` status and the fetched meal;
4. It must be possible to delete a registered meal, returning a status of `200` or `204`.
