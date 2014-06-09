## Memcache Basics
You introduce Memcache to improve a site's performance to cache the results of expensive operations.  Common uses include caching the results of complex database queries, results from 3rd party API calls, or any other calculation that is expensive to compute.

Memcache provides a key-value store, allowing you to retrieve arbitrary objects with any key from the store.  So once you have executed a complex database query you can store the results in Memcache and future page loads can use the cached results until you invalidate the results (as in the data is only valid for 10 minutes).

## Distributed Storage
You can run just 1 Memcache server instance for your site, but it really shines with more than 1.  If you had 2 Memcache servers running, then each key in your key-value store only appears *once* between the Memcache servers.  What this means is that your key-value store is distributed across the instances, and no one Memcache server has to have the entire key-value store in-memory at once.

A benefit of this comes into play if you ever turn off a Memcache server.  Your web server will have cache misses for a bit and the existing Memcache network will store those misses, but everything works and your load is still better than if you didn't have any caching in place.  Likewise, spawning up a new Memcache server will decrease your load on each Memcache server as it distributes the store across all the servers in the cluster.

## Caching with Rails
In Rails you can hook up any cache store to the Rails cache, allowing you to directly manipulate the cache as needed, or many of the more sophisticated Rails caching techniques such as Russian doll caching of your views.  Rails allows you to render a partial for a `Post` instance once, and use that cached result until the record is updated in the database - all automatically.  Behind the scenes it uses the same concepts mentioned above with cache invalidation and key-value storage.
