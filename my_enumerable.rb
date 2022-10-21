# frozen_string_literal: true

# module MyEnumerable
module MyEnumerable
  def my_inject(value = nil)
    result = value.nil? ? 0 : value
    i = 0
    while i < size
      result = yield(result, self[i])
      i += 1
    end
    result
  end

  def my_reject
    element = []
    i = 0
    if block_given?
      while i < size
        element.push(self[i]) if yield(self[i]) == false
        i += 1
      end
      element
    else
      to_enum(:my_reject)
    end
  end

  def my_all?(value = nil)
    if !value.nil?
      each do |ar_item|
        return false unless value === ar_item
      end
    elsif block_given?
      each do |ar_item|
        return false unless yield(ar_item)
      end
    else
      each do |ar_item|
        return false unless ar_item
      end
    end
    true
  end

  def my_include?(value)
    each do |ar_item|
      return true unless value != ar_item
    end
    false
  end

  def my_none?(value = nil)
    if !value.nil?
      each do |ar_item|
        return false if value === ar_item
      end
    elsif block_given?
      each do |ar_item|
        return false if yield(ar_item)
      end
    else
      each do |ar_item|
        return false if ar_item
      end
    end
    true
  end

  def my_any?(value = nil)
    if !value.nil?
      each do |ar_item|
        return true if value === ar_item
      end
    elsif block_given?
      each do |ar_item|
        return true if yield(ar_item)
      end
    else
      each do |ar_item|
        return true if ar_item
      end
    end
    false
  end

  def my_each
    i = 0
    if block_given?
      while i < size
        yield(self[i])
        i += 1
      end
      self
    else
      to_enum(:my_each)
    end
  end

  def my_map!
    i = 0
    if block_given?
      while i < size
        self[i] = yield(self[i])
        i += 1
      end
      self
    else
      to_enum(:my_map!)
    end
  end

  def my_map
    i = 0
    temp = []
    if block_given?
      while i < size
        temp[i] = yield(self[i])
        i += 1
      end
      return temp
    end
    self
  end

  def my_length
    size = 0
    each { size += 1 }
    size
  end

  def my_size
    my_length
  end

  def my_count(value = nil)
    return my_length if value.nil? && !block_given?

    if !value.nil?
      counter = 0
      each do |i|
        counter += 1 if i == value
      end
      counter
    else
      counter = 0
      each do |i|
        counter += 1 if yield(i)
      end
      counter
    end
  end

  def my_select
    temp = []
    i = 0
    k = 0
    if block_given?
      while i < my_size
        if yield(self[i])
          temp[k] = self[i]
          k += 1
        end
        i += 1
      end
      temp
    else
      to_enum(:my_select)
    end
  end

  def my_find
    return to_enum(:my_find) unless block_given?
    each { |item| return item if yield(item) }
  end

  def my_find_all
    temp = []
    return to_enum(:my_find_all) unless block_given?

    each { |item| temp.push(item) if yield(item) }
    temp
  end

  def my_find_index(value = nil)
    i = 0
    if value != nil
      each do |item|
        return i if item == value
        i += 1
      end
    end
    return to_enum(:my_find_index) unless block_given?

    each do |item|
      return i if yield(item)
      i += 1
    end
  end

  def my_max(value = nil)
    arr = self
    each_index do |j|
      (arr.length - 1).downto j do |i|
        arr[i-1], arr[i] = arr[i], arr[i-1] if arr[i] > arr[i-1]
      end
    end
    if !value.nil? && !block_given?
      if value == 0
        []
      else
        arr[0..value-1]
      end
    elsif !value.nil? && block_given?
      
        arr[0..value-1]
      
     
    else
      arr[0]
    end
  end

  def my_min(value = nil)
    swap = true
    size = self.length - 1
    while swap
      swap = false
      for i in 0...size
        swap = self[i] > self[i + 1]
        self[i], self[i+1] = self[i + 1], self[i] if swap
      end
      size -= 1
    end
    if !value.nil? && !block_given?
      if value == 0
        []
      else
        self[0..value-1]
      end
    elsif !value.nil? && block_given?
      if value == 0
        []
      else
        swap_block = true
        size = value - 1
        while swap_block
          swap_block = false
          for i in 0...size
            swap_block = yield(self[i], self[i + 1])
            self[i], self[i+1] = self[i + 1], self[i] if swap_block
          end
        size -= 1
        end
        self[0..value-1]
      end
     
    else
      self[0]
    end
  end
end

class Array
  include MyEnumerable
end
