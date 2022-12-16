#include <catch2/catch_test_macros.hpp>
#include <example/example.hpp>

TEST_CASE("test is odd") {
  CHECK(example::is_odd(3));
  CHECK_FALSE(example::is_odd(4));
}
