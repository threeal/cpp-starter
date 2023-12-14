#include <catch2/catch_test_macros.hpp>
#include <example/example.hpp>

TEST_CASE("test fibonacci sequence") {
  CHECK(example::fibonacci_sequence(-1) == std::vector<int>{});
  CHECK(example::fibonacci_sequence(0) == std::vector<int>{});
  CHECK(example::fibonacci_sequence(1) == std::vector<int>{1});
  CHECK(example::fibonacci_sequence(2) == std::vector<int>{1, 1});
  CHECK(example::fibonacci_sequence(5) == std::vector<int>{1, 1, 2, 3, 5});
}
