# WorkingHoursReport

**Chapter I - Module 2 - Challenge 01**

Must generate a report from a `.csv` file.
The return must be in the following format:
```Elixir
%{
    "all_hours" => %{
        "danilo" => 500,
        "rafael" => 854,
        ...
    },
    "hours_per_month" => %{
        "danilo" => %{
            "janeiro" => 40,
            "fevereiro" => 64,
            ...
        },
        "rafael" => %{
            "janeiro" => 52,
            "fevereiro" => 37,
            ...
        }
    },
    "hours_per_year" => %{
        "danilo" => %{
            "2016" => 276,
            "2017" => 412,
            ...
        },
        "rafael" => %{
            "2016" => 376,
            "2017" => 348,
            ...
        }
    }
}
```
**Chapter I - Module 2 - Challenge 02**

Like the previous challenge, but using parallelism to process the report.
Create a new function that receives a list with the names of the `.csv` files that are divided into more than one file.
