(1..17).to_a.shuffle.each do |code|
  SDG::Goal.where(code: code).first_or_create!
end

%w[
  1.1 1.2 1.3 1.4 1.5 1.A 1.B
  2.1 2.2 2.3 2.4 2.5 2.A 2.B 2.C
  3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 3.A 3.B 3.C 3.D
  4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.A 4.B 4.C
  5.1 5.2 5.3 5.4 5.5 5.6 5.A 5.B 5.C
  6.1 6.2 6.3 6.4 6.5 6.6 6.A 6.B
  7.1 7.2 7.3 7.A 7.B
  8.1 8.2 8.3 8.4 8.5 8.6 8.7 8.8 8.9 8.10 8.A 8.B
  9.1 9.2 9.3 9.4 9.5 9.A 9.B 9.C
  10.1 10.2 10.3 10.4 10.5 10.6 10.7 10.A 10.B 10.C
  11.1 11.2 11.3 11.4 11.5 11.6 11.7 11.A 11.B 11.C
  12.1 12.2 12.3 12.4 12.5 12.6 12.7 12.8 12.A 12.B 12.C
  13.1 13.2 13.3 13.A 13.B
  14.1 14.2 14.3 14.4 14.5 14.6 14.7 14.A 14.B 14.C
  15.1 15.2 15.3 15.4 15.5 15.6 15.7 15.8 15.9 15.A 15.B 15.C
  16.1 16.2 16.3 16.4 16.5 16.6 16.7 16.8 16.9 16.10 16.A 16.B
  17.1 17.2 17.3 17.4 17.5 17.6 17.7 17.8 17.9 17.10 17.11 17.12 17.13 17.14 17.15 17.16 17.17 17.18 17.19
].each do |code|
  SDG::Target.where(code: code, goal: SDG::Goal.find_by!(code: code.split(".").first)).first_or_create!
end

SDG::Phase.kinds.values.each { |kind| SDG::Phase.where(kind: kind).first_or_create! }
