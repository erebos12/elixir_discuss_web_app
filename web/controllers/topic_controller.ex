defmodule Discuss.TopicController do
  use Discuss.Web, :controller
  alias Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
       {:ok, _topic} ->
          conn
          |> put_flash(:info, "Topic Created")
          |> redirect(to: topic_path(conn, :index))
       {:error, changeset} ->
          render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
     topic = Repo.get(Topic, topic_id) # get topic by ID from DB
     changeset = Topic.changeset(topic) # creating a changeset with topic from DB
     render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
     {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    # get!/2 and delete!/1 (!stand for BANG) automatically throws an error if something goes wrong
    # so no case-handling needed here
    Repo.get!(Topic, topic_id) |> Repo.delete!
    # if get!/2 and delete!/1 succeeds then go on here
    conn
    |> put_flash(:info, "Topic deleted!")
    |> redirect(to: topic_path(conn, :index))
  end

end






