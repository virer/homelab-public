# Homelab Infrastructure Map

Cluster domain: `lab.virer.net`  
OpenShift console: <https://console-openshift-console.apps.lab-ocp.virer.net/>

```mermaid
flowchart LR
    WAN[Internet / WAN] --> GW[nanopi gateway\n100.100.0.1]
    GW --> LAN[(Homelab LAN\n100.100.0.0/24)]

    subgraph EDGE["Edge / rev proxy"]
        direction TB
        RP[HAProxy on rtx]
        RP10[host / mgmt\n100.100.0.10]
        RP11[frontend lab-a\n100.100.0.11]
        RP12[frontend lab-o\n100.100.0.12]
        RP --> RP10
        RP --> RP11
        RP --> RP12
    end

    subgraph COMPUTE["Hypervisors"]
        direction TB
        Z240[z240\n100.100.0.9]
        RTX[rtx\n100.100.0.10]
        YOLO[yolo\n100.100.0.6]
    end

    subgraph PLATFORM["Kubernetes"]
        direction TB
        subgraph OCP["OpenShift - lab.virer.net"]
            direction TB
            BOOT[bootstrap\n100.100.0.19]
            E1[etcd-1\n100.100.0.21]
            E2[etcd-2\n100.100.0.22]
            E3[etcd-3\n100.100.0.23]
            W1[worker-1\n100.100.0.31]
            W2[worker-2\n100.100.0.32]
            W3[worker-3\n100.100.0.33]
        end
        HCP[hcp-balvenie.lab\napps + api/api-int + metal-lb]
        SNO[sno1.lab\nsingle-node\n100.100.0.111]
        LABA[lab-a nodes\n100.100.0.60-66]
        LABO[lab-o nodes\n100.100.0.76]
    end

    subgraph SERVICES["Services utilitaires"]
        direction TB
        OMV[omv\n100.100.0.18\ns3]
        REG[registry\n100.100.0.142\nquay proxy]
    end

    LAN --> EDGE
    LAN --> COMPUTE
    LAN --> PLATFORM
    LAN --> SERVICES
    RTX -. hosts .-> RP
```

## Inventory (Quick Reference)

### Core Network
- `nanopi` = `100.100.0.1`

### Hyperviseurs
- `z240` = `100.100.0.9` (was `118`)
- `rtx` = `100.100.0.10` (was `130`)
- `yolo` = `100.100.0.6`

### Reverse Proxy (HAProxy sur `rtx`)
- `lab-a endpoint` = `100.100.0.11`
- `lab-o endpoint` = `100.100.0.12`

### Services utilitaires
- `omv` = `100.100.0.18`  
  s3
- `registry` = `100.100.0.142`  
  quay proxy

### OpenShift (`lab.virer.net`)
- `bootstrap` = `100.100.0.19`
- `etcd-1` = `100.100.0.21`
- `etcd-2` = `100.100.0.22`
- `etcd-3` = `100.100.0.23`
- `worker-1` = `100.100.0.31`
- `worker-2` = `100.100.0.32`
- `worker-3` = `100.100.0.33`

### `lab-a`
- `bootstrap.lab-a` = `100.100.0.60`
- `etcd-1.lab-a` = `100.100.0.61`
- `worker-3.lab-a` = `100.100.0.66`

### `hcp-balvenie.lab`
- `*.apps.hcp-balvenie.lab` = `100.100.0.71`
- `*.apps.hcp-balvenie.lab` = `100.100.0.73`
- `api.hcp-balvenie.lab` = `100.100.0.80`
- `api-int.hcp-balvenie.lab` = `100.100.0.80`
- `metal-lb` = `100.100.0.80-99`

### `lab-o`
- `worker-3.lab-o` = `100.100.0.76`

### `sno1.lab`
- `api.sno1.lab` = `100.100.0.111`
- `api-int.sno1.lab` = `100.100.0.111`
- `*.apps.sno1.lab` = `100.100.0.111`
- `sno1.lab` = `100.100.0.111`