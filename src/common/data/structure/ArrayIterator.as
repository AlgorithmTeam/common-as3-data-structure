/**
 * User: Ray Yee
 * Date: 14-2-10
 * All rights reserved.
 */
package common.data.structure
{
    final public class ArrayIterator extends Array implements Iterator
    {
        public function ArrayIterator( ...rest )
        {
            super( rest );
        }

        public function get hasNext():Boolean
        {
            return length > 0;
        }

        public function get first():*
        {
            return this[0];
        }

        public function get next():*
        {
            return pop();
        }
    }
}
