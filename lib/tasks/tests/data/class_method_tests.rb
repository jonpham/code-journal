describe '#method01' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("null")
    expect(uut.method01(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
  end
end

describe '#method02' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("[\"hello\",\"world!\"]")
    expect(uut.method02(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
  end
end

describe '#method03' do
  it 'should return "This is me saying, hello world!"' do
    uut = build_uut()
    args = JSON.parse("[[\"hello\",\"world!\"]]")
    expect(uut.method03(args)).to eq(JSON.parse("\"This is me saying, hello world!\""))
  end
end
