import { useEffect, useState } from 'react';
import './App.css';
import { backend } from './declarations/backend';
import { User } from './declarations/backend/backend.did';

function App() {
  let users_: User[] = [];
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(false);
  // Get the current counter value
  const fetchUsers = async () => {
    try {
      setLoading(true);
      let userList = await backend.getUsers();
      while (userList?.[0]?.[0].id) {
        users_ = [...users_, userList[0][0]];
        setUsers(users_);
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
  const [id, setId] = useState('');
  return (
    <div className="App">
      <input type="text" value={id} onChange={(e) => setId(e.target.value)} />
      <div className="card">
        {users.map((data) => {
          return <p>{data.email}</p>;
        })}
        {/* <button onClick={fetchComments}>fetch</button> */}
      </div>
    </div>
  );
}

export default App;
