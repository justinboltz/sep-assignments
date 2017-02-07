require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
    @root.checked = 0
    @movies = 0
  end

  def insert(root, node)
    currNode = root
    if node.rating > currNode.rating
      if currNode.right == nil
        currNode.right = node
        currNode.right.parent = currNode
      else
        insert(currNode.right, node)
      end
    elsif node.rating < currNode.rating
      if currNode.left == nil
        currNode.left = node
        currNode.left.parent = currNode
      else
        insert(currNode.left, node)
      end
    else
      return "error, no duplicate ratings"
    end
  end

  # Recursive Depth First Search
  def find(node, target)
    # check node
    return node if node.title == target
    #check for right child
    if node.right != nil
      find(node.right, target)
    # check for left child
    elsif node.left != nil
      find(node.left, target)
    # move back up the tree
    else
      while node.parent != nil && (node.parent.left == nil || node.parent.left == node)
        node = node.parent
      end
      # value not found
      if node == @root
        @root.checked += 1
        if @root.checked == 1 && @root.left == nil && @root.right == nil
          @root.checked = 0
          return nil
        end
        if @root.checked == 2 && @root.left == nil
          @root.checked = 0
          return nil
        end
        if @root.checked == 3
          @root.checked = 0
          return nil
        end
      # continue the search
      else
        find(node.parent.left, target)
      end
    end
  end

  def delete(root, data)
    found = find(root, data)
    return nil if found == nil
    # move the left child to take deleted node's place
    if found.left != nil
      # connect deleted node's parent to new child
      if found.parent.right == found
        found.parent.right = found.left
      else
        found.parent.left = found.left
      end
      # connect deleted node's other child to new parent
      if found.right != nil
        found.right.parent = found.left
        found.left.right = found.right
      end
      # connect left node to new parent
      found.left.parent = found.parent
    # move right child to take deleted node's place if no left child
    elsif found.right != nil
      # connect deleted node's parent to new child
      if found.parent.right == found
        found.parent.right = found.right
      else
        found.parent.left = found.right
      end
      # connect right node to new parent
      found.right.parent = found.parent
    # no children to shift, just remove relation to parent
    else
      if found.parent.right == found
        found.parent.right = nil
      end
      if found.parent.left == found
        found.parent.left = nil
      end
    end
    # free memory for deleted node
    found = nil
  end

  # Recursive Breadth First Search
  def printf(children=nil)
  end
end
