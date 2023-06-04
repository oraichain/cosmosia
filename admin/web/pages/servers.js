import { useSession } from "next-auth/react";
import { listServers } from '/helper/docker_api';
import { Table, Tag, Progress, Dropdown } from 'antd';
import { format2Decimal } from "/helper/utils";
import { CheckCircleOutlined, DownOutlined } from '@ant-design/icons';
import { useRouter } from 'next/router';

export async function getServerSideProps() {
  let serverList = [];
  try {
    serverList = await listServers();
  } catch (err) {
    // do nothing
  }

  return {props: {serverList}};
}

const ServerTable = (props) => {
  const router = useRouter();
  const {data} = props;

  const tagCloseHandler = ({Hostname, tag}) => {
    router.push(`/node_label_remove?swarm_node=${Hostname}&label=${tag}`);
  };

  return (
    <Table
      columns={[
        {
          title: 'Hostname',
          dataIndex: 'Hostname',
          key: 'Hostname',
          width: 150,
          // render: (text) => <a>{text}</a>,
          sorter: (a, b) => {
            return (a.Hostname < b.Hostname) ? -1 : (a.Hostname > b.Hostname) ? 1 : 0;
          },
          sortDirections: ['ascend', 'descend'],
        },
        {
          title: 'IP',
          dataIndex: 'Addr',
          key: 'Addr',
          width: 150,
          // render: (text) => <a>{text}</a>,
          sorter: (a, b) => {
            return (a.Addr < b.Addr) ? -1 : (a.Addr > b.Addr) ? 1 : 0;
          },
          sortDirections: ['ascend', 'descend'],
        },
        {
          title: 'State',
          dataIndex: 'State',
          key: 'State',
          width: 60,
          render: (text) => {
            if (text === "ready") {
              return <CheckCircleOutlined style={{color: 'green'}}/>;
            }

            return <>{text}</>
          },
        },
        {
          title: 'Resource',
          dataIndex: 'resource',
          key: 'resource',
          width: 200,
          render: (resource) => {
            if (resource === null) {
              return null;
            }

            const {cpu_usage, ram_total, ram_usage, disk_size, disk_usage} = resource;
            let cpuUsageValue = parseFloat(cpu_usage);
            let ramUsageValue = parseFloat(ram_usage);
            let diskUsageValue = parseFloat(disk_usage);

            return (
              <>
                <div>
                  <div className="resourceLabel">CPU</div>
                  <Progress percent={format2Decimal(cpuUsageValue)} size="small"/>
                </div>
                <div>
                  <div className="resourceLabel">RAM ({ram_total})</div>
                  <Progress percent={format2Decimal(ramUsageValue)} size="small"/>
                </div>
                <div>
                  <div className="resourceLabel">HDD ({disk_size})</div>
                  <Progress percent={format2Decimal(diskUsageValue)} size="small"/>
                </div>
              </>
            );
          },
        },
        {
          title: 'Labels',
          key: 'Tags',
          dataIndex: 'Tags',
          render: (_, { Hostname, Tags }) => (
            <>
              {Tags.map((tag) => <Tag key={tag} closable onClose={(e) => {
                e.preventDefault();
                tagCloseHandler({Hostname, tag});
              }}>{tag}</Tag>)}
            </>
          ),
        },
        {
          title: 'Action',
          dataIndex: 'operation',
          key: 'operation',
          render: (_, { Hostname }) => (
            <Dropdown
              menu={{
                items: [
                  {
                    key: 'node_label_add',
                    label: 'Add Label',
                  },
                ],
                onClick: ({key}) => {
                  if (key === 'node_label_add') {
                    router.push(`/node_label_add?swarm_node=${Hostname}`);
                  }
                },
              }}
            >
              <a onClick={(e) => e.preventDefault()}>More <DownOutlined /></a>
            </Dropdown>
          ),
        },
      ]}
      dataSource={data}
      pagination={false}
    />
  );
}


export default function Servers({serverList}) {
  const {data: session, status} = useSession();

  if (status === "unauthenticated") return <p>Access Denied.</p>

  return (
    <div className="Servers">
      <h3>Servers</h3>

      <ServerTable data={serverList}/>
    </div>
  )
}