#include <cstdlib>
#include <iostream>
#include <my_fibonacci/sequence.hpp>

int main(int argc, char **argv) {
  if (argc < 2) {
    std::cerr << "Usage: " << argv[0] << " <n>" << std::endl;
    return 1;
  }

  const auto sequence = my_fibonacci::fibonacci_sequence(std::atoi(argv[1]));
  for (auto val : sequence) {
    std::cout << val << " ";
  }
  std::cout << std::endl;

  return 0;
}
