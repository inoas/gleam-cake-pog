import birdie
import cake/adapter/postgres
import cake/insert as i
import pprint.{format as to_string}
import test_helper/postgres_test_helper

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Setup                                                                    │
// └───────────────────────────────────────────────────────────────────────────┘

fn insert_values() {
  [[i.string("Whiskers"), i.float(3.14), i.int(42)] |> i.row]
  |> i.from_values(table_name: "cats", columns: ["name", "rating", "age"])
  |> i.returning(["name"])
}

fn insert_values_query() {
  insert_values()
  |> i.to_query
}

// ┌───────────────────────────────────────────────────────────────────────────┐
// │  Test                                                                     │
// └───────────────────────────────────────────────────────────────────────────┘

pub fn insert_values_test() {
  let pgo = insert_values_query()

  pgo
  |> to_string
  |> birdie.snap("insert_values_test")
}

pub fn insert_values_prepared_statement_test() {
  let pgo = insert_values_query() |> postgres.write_query_to_prepared_statement

  pgo
  |> to_string
  |> birdie.snap("insert_values_prepared_statement_test")
}

pub fn insert_values_execution_result_test() {
  let pgo = insert_values_query() |> postgres_test_helper.setup_and_run_write

  pgo
  |> to_string
  |> birdie.snap("insert_values_execution_result_test")
}
