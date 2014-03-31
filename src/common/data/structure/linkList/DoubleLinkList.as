package common.data.structure.linkList
{
    import common.data.structure.Iterator;

    /**
	 *
	 * 创建者：njw
	 * 修改者：Ray Yee
	 * 说明：双向链表 (为加快查询速度，可以额外再用HashMap保存节点）
	 */
	public class DoubleLinkList
	{
		/*
		* 索引从0开始 ,所有对节点间的操作都应由链表自行管理
		*/
		
		private var m_FirstNode:LinkNode;
		private var m_LastNode:LinkNode;
		private var m_Length:int = 0;
		
		public function DoubleLinkList()
		{
//			if(null == node) 
//			{
//				throw Error("链表首节点不能为空");
//			}
//			
//			m_FirstNode	= node;
//			m_LastNode	= node;
//			m_Length = 1;
		}

        public function getLength():int
		{
			return 	m_Length;
		}
		
		public function setFirstNode(node:LinkNode):void
		{
			if(null == 	node) return;
			node.m_NextNode = m_FirstNode;
			node.m_PrevNode = null;
			m_FirstNode = node;
		}

        public function shiftNode():LinkNode
        {
            var node:LinkNode = m_FirstNode;
            if (node == null) return null;
            var nextNode:LinkNode = m_FirstNode.m_NextNode;
            if (nextNode)
            {
                nextNode.m_PrevNode = null;
                m_FirstNode = nextNode;
                m_Length--;
            }
            else
            {
                m_FirstNode = null;
                m_LastNode = null;
                m_Length = 0;
            }
            node.m_NextNode = null;
            node.m_PrevNode = null;
            return node;
        }
		
		public function popNode():LinkNode
		{
            var node:LinkNode = m_LastNode;
            if (node == null) return null;
			var prevNode:LinkNode = m_LastNode.m_PrevNode;
			if (prevNode)
			{
				prevNode.m_NextNode = null;
				m_LastNode = prevNode;
				m_Length--;
			}
			else
			{
				m_FirstNode	= null;
				m_LastNode	= null;
				m_Length = 0;
			}
            node.m_NextNode = null;
            node.m_PrevNode = null;
            return node;
		}
		
		public function pushNode(node:LinkNode):void
		{
			if(null == node) return;
			
			if(m_FirstNode)
			{
				m_LastNode.m_NextNode = node;
				node.m_PrevNode = m_LastNode; 
			}
			else
			{
				m_FirstNode = node;
			}
			m_LastNode = node;
			
			m_Length++;
		}
		
		/**
		 * 移动节点到目标节点前或者后
		*/
		public function moveNode(node:LinkNode,targetNode:LinkNode,isPrev:Boolean = true):void
		{
			//先要判断两个节点是否属于此链表
//			hasNode();
			
			deleteNode(node);
			insertNode(node,targetNode,isPrev);
		}
		
		public function getNodeByData(data:Object):LinkNode
		{
			var node:LinkNode = m_FirstNode;
			while(node)
			{
				if(node.m_NodeData == data) return node;
				node = node.m_NextNode;
			}
			return node;
		}
		
		public function getNode(index:int):LinkNode
		{
			if(getLength() == 0) return null;
			
			var node:LinkNode;
			
			//二分查找，提高搜索效率
			if(index > (m_Length / 2))
			{
				node = m_LastNode;
				var endIndex:int = m_Length - index - 1;
				while(endIndex--)
				{
					node = node.m_PrevNode;
				}
			}
			else
			{
				node = m_FirstNode;
				while(index--)
				{
					node = node.m_NextNode;
				}
			}
			return node;
		}
		
		public function insertNode(node:LinkNode,targetNode:LinkNode,isPrev:Boolean = true):void
		{
			if(isPrev)
			{
				node.m_NextNode = targetNode;
				var prevNode:LinkNode = targetNode.m_PrevNode;
				targetNode.m_PrevNode = node;
				if(prevNode)
				{
					prevNode.m_NextNode = node;
					node.m_PrevNode = prevNode; 
				}
				else
				{
					m_FirstNode = node;	
				}	
			}
			else
			{
				node.m_PrevNode = targetNode;
				var nextNode:LinkNode = targetNode.m_NextNode;
				targetNode.m_NextNode = node;
				if(nextNode)
				{
					nextNode.m_PrevNode = node;
					node.m_NextNode = nextNode; 
				}
				else
				{
					m_LastNode = node;	
				}	
			}
			m_Length++;
		}
		
		public function insertNodeByIndex(index:int,node:LinkNode):void
		{
			if(null == node) return;
			
			var targetNode:LinkNode = getNode(index);
			if(null == targetNode) return;
			
			insertNode(node,targetNode);
		}
		
		public function hasNode(node:LinkNode):Boolean
		{
			//扩充
			return true;	
		}
		
		public function deleteNode(node:LinkNode):void
		{
			//先要判断是否属于此链表
//			hasNode();
			
			var prevNode:LinkNode = node.m_PrevNode;
			var nextNode:LinkNode = node.m_NextNode;
			if(null == prevNode)
			{
				m_FirstNode = nextNode;
				if(nextNode)
				{
					nextNode.m_PrevNode = null;			
				}
				else
				{
					m_LastNode = null;
				}
			}
			else
			{
				prevNode.m_NextNode = nextNode;
				if(nextNode)
				{
					nextNode.m_PrevNode = prevNode;
				}
				else
				{
					m_LastNode = prevNode;
				}
			}
			node.m_PrevNode = null;
			node.m_NextNode = null;
			m_Length--;
		}
		
		public function deleteNodeByIndex(index:int):void
		{
			var node:LinkNode = getNode(index);
			if(null == node) return;
			deleteNode(node);
		}
		
		public function join(node:LinkNode,callBack:Function):Boolean
		{
			if(null == node) return false;
			if(null == callBack) return false;
			if(getLength() == 0) return false;
			var checkNode:LinkNode = m_FirstNode;
			while(checkNode)
			{
				var flag:Boolean = callBack(checkNode.m_NodeData,node.m_NodeData);
				if(flag)
				{
					node.m_NextNode = checkNode;
					checkNode.m_PrevNode = node; 
					if(checkNode == m_FirstNode)
					{
						m_FirstNode = node;
					}
					m_Length++;
					return true;
				}
				checkNode = checkNode.m_NextNode;
			}
			return false;
		}
	}
}