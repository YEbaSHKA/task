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
      element = []
      i = 0
      if block_given?
        while i < size
          if yield(self[i]) == false
            element.push(self[i])
          end
          i += 1
        end
        element
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

    def my_map
        i = 0
        temp = Array.new
        if block_given?
          while i < size
            temp[i] = yield(self[i])
            i += 1
          end
          return temp
        end
        return self
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
      i = 0
      result = 0
      if !value.nil?
        while i < my_size
          if self[i] == value
            result += 1
          end
          i += 1
        end
          result 
        
      elsif block_given?
        if self.empty?
          result
        else 
          while i < my_size
            if yield(self[i])
              result += 1
            end
            i += 1
          end
          result
        end
      else
        self.my_size 
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
        self
      end
    end

    def my_find
      return to_enum(:my_find) unless block_given?
      each { |item| return item if yield(item) }
      false
    end

    def my_find_all
      temp = []
      return to_enum(:my_find_all) unless block_given?
      each { |item| temp.push(item)  if yield(item)}
      temp
    end

    def my_find_index
        i = 0
        return to_enum(:my_find_index) unless block_given?
        each do |item| 
          return i if yield(item)
          i += 1
        end
    end
    
    def my_max(value = nil, &blc)
      if value.nil? && !block_given?
        max_value = self[0]
        each {|item| max_value = item if max_value < item }
        max_value
      elsif !block_given?
        arr = []
        self.sort
        arr = self.sort{|a, b| b <=> a}
        if value == 0
         arr = []
        else
        arr[0..value-1]
        end
      else
        arr = []
        i = 0
        if value.nil?
         while i < size - 1
           arr = yield(self[i], self[i+1])
           i += 1
         end
         self[0] 
        elsif value == 0
         arr = []
        else
         while i < size - 1
           arr = yield(self[i], self[i+1])
           i += 1
         end
         p self
         p self.sort{|a, b| a <=> b }
         self[0..value-1]
       end
        
      end
    
    end
      
    def my_min(value = nil, &blc)
      if value.nil? && !block_given?
        min_value = self[0]
        each {|item| min_value = item if min_value > item }
        min_value
      elsif !block_given?
        arr = []
        arr = self.sort
        if value == 0
         arr = []
        else
        arr[0..value-1]
        end
      else
        arr = []
        i = 0
        if value.nil?
         while i < size - 1
           arr = yield(self[i], self[i+1])
           i += 1
         end
         self[0] 
        elsif value == 0
         arr = []
        else
         while i < size - 1
           arr = yield(self[i], self[i+1])
           i += 1
         end
         self[0..value-1]
       end
        
      end
    
    end

  end
  
  class Array
    include MyEnumerable
  end