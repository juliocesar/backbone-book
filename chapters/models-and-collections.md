<% @title = 'Models and collections' %>

<h1>
  Models and collections
</h1>

<h2>
  Models
</h2>

<p>
  Although they reflect data that's on the server, they're not meant to be **a mirror** of what the server model is, so this business of replicating every relation and validation that exists on the other side is time wasted. It may come down to that, but there'll be a use case on the client app to justify it, or it's useless.
</p>

<p>
  Views will listen to attribute changes that happen on your models, so plan accordingly as you'll be listening to changes in specific attributes with views. For example, it's fine for you to have an attribute in <code>Book</code> called <code>paid</code> that's stale, as in it exists only on the client side (the server knows it's paid because there's an associated payment entry). So just setting <code>paid</code> to <code>true</code> re-renders whatever view associated itself with this model and renders an appropriate template that shows that this thing is paid for.
</p>

<p>
  Before you cry that Backbone will always commit every model attribute to the server, the solution is simple: declare a list of stale attributes (they're likely gonna be lesser in number than the others), and omit them from what gets sent by overriding <code>toJSON()</code>:
</p>

<pre>
  <code>var Book = Backbone.Model.extend({
  stale: ['paid'],

  toJSON: function() {
    return _.omit(this.attributes, this.stale);
  }
});</code>
</pre>

<p>
  Don't clutter models with a lot of methods for rendering attributes in different ways, human-friendly, different date formats, and so on. Write a presenter object that's **separate** to the model, which you can pass the model to it's methods and it'll handle that for you. Then pass that presenter to the view (more on that in an upcoming chapter).
</p>

<h2>
  Collections
</h2>

<p>
  Collections are cool and shit.
</p>

<h2>
  API <span class="amp">&amp;</span> strategies
</h2>

<p>
  Most apps communicate with a server using HTTP with a RESTful API. So the API URLs are of summary importance. Don't scatter them around the app. Write a module named `apiUrl` which exports a function with the same name. That module acts like a catalog of URLs, and model or collection that talks with the API has to require it. It looks like this:
</p>

<pre>
  <code># List of API URLs.
var URLs = {
  books: function() {
    return "/api/books";
  },
  book: function(id) {
    return "/api/books/" + id;
  },
  subscriptions: function(userId, id) {
    return "/api/users/" + userId + "/subscriptions/" + id;
  }
}

# Helper for accessing the URL list. Think of it as something similar
# to Rails' URL helpers.
var apiUrl = function() {
  var args = [].slice.call(arguments),
      name = args.unshift();
  return URLs[name] ? URLs[name].apply(URLs, args) : undefined;
}

if (typeof module !== 'undefined') {
  module.exports = apiUrl
} else {
  this.apiUrl = apiUrl
}</code>
</pre>

<p>
  Then forever (no exceptions) refer to URLs by calling this module. In a `Book` model, it'd look like this:
</p>

<pre>
  <code>var Book = Backbone.Model.extend({
  url: function() {
    return apiUrl('book', this.id);
  }
});</code>
</pre>

<p>
  Data associations are easy to solve without plugins **if your API is sane**, so it's worth making it so otherwise your data layer will absorb your API's ugliness and amplify it by one hundred. Assume we have authors for those books I spoke of, and when fetching an author, I want to grab their books along. Say the API looks like this:
</p>

<pre>
  <code>GET   /api/authors/1?with=books</code>
</pre>

<p>
  And by calling this URL I get the author object along with a `books` attribute which is an array of book objects, here's how you'd do it:
</p>

<pre>
  <code>var Author = Backbone.Model.extend({
  initialize: function() {
    this.books = new Books(this.get('books'), { url: apiUrl('books', this.id) });
  }
});</code>
</pre>

<p>
  Now make sure from now on you refer to *the collection* to access the values and not the container model attribute. The collection will contain the representation of what the author's books are, and ensure the book model instances are in sync with the server.
</p>

<p>
  Loading associated data is trivial once you think for a second about what makes sense. Assume you
</p>
