#include <my_fibonacci/sequence.hpp>

#include <algorithm>

namespace my_fibonacci {

std::vector<int> fibonacci_sequence(int n) {
  std::vector<int> sequence(std::max(n, 0), 1);
  for (int i{2}; i < n; ++i) {
    sequence[i] = sequence[i - 2] + sequence[i - 1];
  }
  return sequence;
}

}  // namespace my_fibonacci
