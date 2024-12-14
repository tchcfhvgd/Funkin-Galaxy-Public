package flixel.util.tools;

class IteratorTools
{


    public function new()
    {
       
    }
    static public function array(iterator)
    {
       var _g = [];
       var i = iterator;
       while (i.hasNext()) {
         var i1 = i.next();
         _g.push(i1);
       }
       return _g;
    }
    static public function count(iterator, predicate)
    {
       var n = 0;
       if (predicate == null) {
         var _ = iterator;
         while (_.hasNext()) {
           var _1 = _.next();
           ++n;
         }
       } else {
         var x = iterator;
         while (x.hasNext()) {
           var x1 = x.next();
           if (predicate(x1)) {
             ++n;
           }
         }
       }
       return n;
    }

}