# frozen_string_literal: true

# module MyEnumerable
module MyEnumerable
    def my_inject (value = nil)
      result = value.nil? ? 0 : value
      i = 0
      while i < size
        result = yield(result, self[i])
        i += 1
      end
      result
    end
  
    def my_reject
      elemen[] = Array.new
      i = 0
      if block_given?
        while i < size
          if yield(self[i]) == false
            elemen.push(self[i])
          end
          i += 1
        end
        elemen
      else
        self
      end
    end
  
    def my_all? (value = nil)
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
  
    def my_none? (value = nil)
    if !value.nil?
      each do |ar_item|
        if value === ar_item
          return false
        end
      end
    elsif block_given?
      each do |ar_item|
        if yield(ar_item)
          return false
        end
      end
    else
      each do |ar_item|
        if ar_item
          return false
        end
      end
    end
    true
  end
  
  
    def my_any? (value = nil)
      if !value.nil?
        each do |ar_item|
          if value === ar_item
            return true
          end
        end
      elsif block_given?
        each do |ar_item|
          if yield(ar_item)
            return true
          end
        end
      else
        each do |ar_item|
          if ar_item
            return true
          end
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
      end
      self
    end
  
    def my_map!
      i = 0
      if block_given?
        while i < size
          self[i] = yield(self[i])
          i += 1
        end
      end
      self
    end
  end
  
  class Array
    include MyEnumerable
  end