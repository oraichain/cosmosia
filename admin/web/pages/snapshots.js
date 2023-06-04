import { useSession } from "next-auth/react";
import { listSnapshots } from '/helper/docker_api';
import { Table } from 'antd';

export async function getServerSideProps() {
  let snapList = [];
  try {
    snapList = await listSnapshots();
  } catch (err) {
    // do nothing
  }

  return {props: {snapList}};
}

const SnapshotTable = (props) => {
  const {data} = props;

  const dataSrc = [];
  for (const item of data) {
    const {Name} = item;
    dataSrc.push({key: Name, ...item});
  }

  return (
    <Table
      columns={[
        {
          title: 'Name',
          dataIndex: 'Name',
          key: 'Name',
          render: (text) => <>{text}</>,
          sorter: (a, b) => {
            return (a.name < b.name) ? -1 : (a.name > b.name) ? 1 : 0;
          },
          sortDirections: ['ascend', 'descend'],
        },
        {
          title: 'CreatedAt',
          dataIndex: 'CreatedAt',
          key: 'CreatedAt',
          render: (text) => <>{text}</>,
          sorter: (a, b) => {
            return (a.CreatedAt < b.CreatedAt) ? -1 : (a.CreatedAt > b.CreatedAt) ? 1 : 0;
          },
          sortDirections: ['ascend', 'descend'],
        },
      ]}
      dataSource={dataSrc}
      pagination={false}
    />
  );
}


export default function Snapshots({snapList}) {
  const {data: session, status} = useSession();

  if (status === "unauthenticated") return <p>Access Denied.</p>

  return (
    <div className="Snapshots">
      <h3>Snapshots</h3>

      <SnapshotTable data={snapList}/>
    </div>
  )
}