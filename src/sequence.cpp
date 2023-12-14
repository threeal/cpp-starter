#include <my_fibonacci/sequence.hpp>

namespace my_fibonacci {

std::vector<int> fibonacci_sequence(int n) {
  if (n <= 0) return {};
  if (n == 1) return {1};

  std::vector<int> sequence(n);
  sequence[0] = 1;
  sequence[1] = 1;

  for (int i = 2; i < n; ++i) {
    sequence[i] = sequence[i - 2] + sequence[i - 1];
  }

  return sequence;
}

}  // namespace my_fibonacci
