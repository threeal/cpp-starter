#include <my_fibonacci/sequence.hpp>

#include <boost/ut.hpp>

using my_fibonacci::fibonacci_sequence;
using namespace boost::ut;

int main() {
  should("generate a Fibonacci sequence") = [] {
    expect(fibonacci_sequence(-1) == std::vector<int>{});
    expect(fibonacci_sequence(0) == std::vector<int>{});
    expect(fibonacci_sequence(1) == std::vector<int>{1});
    expect(fibonacci_sequence(2) == std::vector<int>{1, 1});
    expect(fibonacci_sequence(5) == std::vector<int>{1, 1, 2, 3, 5});
  };
}
