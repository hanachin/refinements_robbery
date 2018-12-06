class C
  using Module.new { refine(C) { def c; end } }
end

RSpec.describe RefinementsRobbery do
  specify do
    expect { C.new.c }.to raise_error(NoMethodError)
  end
end

using *RefinementsRobbery.rob(C)

RSpec.describe RefinementsRobbery do
  specify do
    expect { C.new.c }.not_to raise_error
  end
end
