import { useEffect, useState } from 'react';
import './App.css';
import { backend } from './declarations/backend';
import { User } from './declarations/backend/backend.did';

function App() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(false);

  // Get the current counter value
  const fetchUsers = async () => {
    try {
      setLoading(true);
      let userList = await backend.getUsers();
      while (userList?.[0]?.[0].id) {
        setUsers([...users, userList[0][0]]);
        userList = userList[0][1];
      }
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };
  // Fetch the count on page load
  useEffect(() => {
    fetchUsers();
  }, []);

  return (
    <div className="App">
      <div className="card">
        hello
        {users.map((data) => {
          return <p>{data.email}</p>;
        })}
      </div>
    </div>
  );
}

export default App;
