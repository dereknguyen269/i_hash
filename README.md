# I_Hash
The new Hash for Ruby.

## Install

GEMFILE:

```bash
  gem 'i_hash', '~> 0.0.1'
```
INSTALL:

```bash
  gem install i_hash
```

## Usage

```ruby
  require 'i_hash'
  
  hash_1 = IHash['a' => 1, 'b' => 2, 'c' => 3]
  # => {"a"=>1, "b"=>2, "c"=>3}
  
  hash_2 = IHash[a: 1, b: 2, c: 3]
  # => {:a=>1, :b=>2, :c=>3}
  
  hash_3 = IHash['a' => 1, b: 2, c: 3]
  # => {"a"=>1, :b=>2, :c=>3}
  
  hash_1.symbolize_keys
  # => {:a=>1, :b=>2, :c=>3}
  hash_2.symbolize_keys 
  # => {:a=>1, :b=>2, :c=>3}
  hash_3.symbolize_keys
  # => {:a=>1, :b=>2, :c=>3}
  
  hash_1.stringify_keys
  # => {"a"=>1, "b"=>2, "c"=>3}
  hash_2.stringify_keys
  # => {"a"=>1, "b"=>2, "c"=>3}
  hash_3.stringify_keys
  # => {"a"=>1, "b"=>2, "c"=>3}
  
  hash_1.compare(hash_2)
  # => {}
  hash_1.compare(hash_3)
  # => {}
  hash_2.compare(hash_3)
  # => {}
  
  hash_4 = IHash['a' => 1, b: 2, c: 10]
  # => {"a"=>1, :b=>2, :c=>10}
  hash_1.compare(hash_4)
  # => {:c=>[3, 10]} 
  hash_1.compare(hash_4).keys
  # => [:c] Diff keys
```
