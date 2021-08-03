# GetRepositories

**Chapter IV - Module 6 - Challenge 01**

Must create an application that consumes the GitHub API returning the list of repositories of an informed user.

For each user repository, you should only return the following fields from the API: `id`, `name`, `description`, `html_url` and `stargazers_count`.

**Chapter IV - Module 6 - Challenge 02**

Must test the client created in the previous challenge using the bypass lib.

**Chapter V - Module 7 - Challenge 01**

Must add a user entity with just `id` and `password`. Afterwards, authentication with JWT token must be added using the created user `id` and `password`. When calling the route that lists a user's repositories, it will also be necessary to send the JWT token of a user who authenticated in the application.