describe '#module01' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("null")
    expect(uut.module1(args)).to eq(JSON.parse("This is me saying, hello world!"))
  end
end

describe '#module02' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("[\"hello\",\"world!\"]")
    expect(uut.module2(args)).to eq(JSON.parse("This is me saying, hello world!"))
  end
end

describe '#module03' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("[\"hello\",\"world!\"]")
    expect(uut.module3(args)).to eq(JSON.parse("This is me saying, hello world!"))
  end
end
